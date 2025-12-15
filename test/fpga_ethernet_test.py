"""
FPGA Ethernet Test Script
Sends raw Ethernet frames to FPGA for MLP testing
"""
import socket
import struct
import time
import random

# Configuration - UPDATE THESE VALUES
# FPGA'ya bağlı interface'in MAC adresi (ipconfig /all ile bul)
LOCAL_MAC = "B0-22-7A-E5-88-CC"  # Senin Realtek Gaming GbE adaptörünün MAC'i
FPGA_MAC = bytes([0x00, 0x0A, 0x35, 0x12, 0x34, 0x56])  # FPGA'nın MAC adresi (top.vhd'deki C_MAC_ADDRESS)

def get_local_mac():
    """Get local MAC address (placeholder - usually need admin rights for raw sockets)"""
    return bytes([0x00, 0x11, 0x22, 0x33, 0x44, 0x55])

def create_ethernet_frame(src_mac, dst_mac, payload):
    """Create a raw Ethernet frame"""
    # EtherType 0x88B5 = Local Experimental Ethertype
    ethertype = 0x88B5
    
    # Ethernet header: Dest MAC (6) + Src MAC (6) + EtherType (2) = 14 bytes
    header = dst_mac + src_mac + struct.pack(">H", ethertype)
    
    # Pad payload to at least 46 bytes (minimum Ethernet payload)
    if len(payload) < 46:
        payload = payload + bytes(46 - len(payload))
    
    return header + payload

def send_test_packet(sock, payload_data):
    """Send a test packet with given payload"""
    src_mac = get_local_mac()
    frame = create_ethernet_frame(src_mac, FPGA_MAC, payload_data)
    sock.send(frame)
    print(f"Sent {len(frame)} bytes: {frame[:20].hex()}...")

def generate_mlp_input(pattern_type=0):
    """Generate 40 bytes of test data for MLP input with different patterns"""
    if pattern_type == 0:
        # All zeros
        return bytes([0] * 40)
    elif pattern_type == 1:
        # All ones (255)
        return bytes([255] * 40)
    elif pattern_type == 2:
        # Ascending pattern
        return bytes([i * 6 % 256 for i in range(40)])
    elif pattern_type == 3:
        # Descending pattern
        return bytes([255 - (i * 6 % 256) for i in range(40)])
    elif pattern_type == 4:
        # Alternating high/low
        return bytes([255 if i % 2 == 0 else 0 for i in range(40)])
    elif pattern_type == 5:
        # Mid-range values
        return bytes([128] * 40)
    elif pattern_type == 6:
        # First half high, second half low
        return bytes([255] * 20 + [0] * 20)
    elif pattern_type == 7:
        # First half low, second half high  
        return bytes([0] * 20 + [255] * 20)
    else:
        # Random
        return bytes([random.randint(0, 255) for _ in range(40)])

def main():
    print("=" * 50)
    print("FPGA Ethernet MLP Test")
    print("=" * 50)
    print(f"Target FPGA MAC: {FPGA_MAC.hex(':')}")
    print()
    
    try:
        # Create raw socket (requires admin/root privileges)
        # On Windows, use npcap/winpcap
        sock = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, socket.htons(0x0003))
        sock.bind((INTERFACE, 0))
        print(f"Bound to interface: {INTERFACE}")
    except AttributeError:
        print("Raw sockets not directly supported on Windows.")
        print("Using alternative method with scapy...")
        use_scapy()
        return
    except PermissionError:
        print("Permission denied! Run as Administrator.")
        return
    except Exception as e:
        print(f"Socket error: {e}")
        print("\nTrying scapy method instead...")
        use_scapy()
        return
    
    print("\nSending test packets...")
    for i in range():
        payload = generate_mlp_input()
        send_test_packet(sock, payload)
        print(f"  Packet {i+1}: sent 40 bytes of random data")
        time.sleep(0.5)
    
    sock.close()
    print("\nDone! Check FPGA LEDs for classification results.")

def use_scapy():
    """Alternative method using scapy library"""
    try:
        from scapy.all import Ether, Raw, sendp, get_if_list, get_if_hwaddr, conf
        
        print("\nSearching for correct interface...")
        
        # Find interface with matching MAC
        target_mac = LOCAL_MAC.lower().replace("-", ":")
        found_iface = None
        
        for iface in get_if_list():
            try:
                mac = get_if_hwaddr(iface).lower()
                if mac == target_mac:
                    found_iface = iface
                    print(f"Found matching interface: {iface}")
                    print(f"  MAC: {mac}")
                    break
            except:
                pass
        
        if not found_iface:
            print(f"\nCould not find interface with MAC {LOCAL_MAC}")
            print("Available interfaces:")
            for iface in get_if_list():
                try:
                    mac = get_if_hwaddr(iface)
                    print(f"  {iface} -> {mac}")
                except:
                    print(f"  {iface} -> (no MAC)")
            return
        
        print(f"\nUsing interface: {found_iface}")
        print("Sending test packets with different patterns...\n")
        
        pattern_names = [
            "All zeros (0x00)",
            "All max (0xFF)",
            "Ascending (0,6,12...)",
            "Descending (255,249...)",
            "Alternating (FF,00,FF...)",
            "Mid-range (0x80)",
            "First half high",
            "Second half high"
        ]
        
        for i in range(8):
            payload = generate_mlp_input(i)
            
            # Create Ethernet frame
            frame = Ether(
                dst=":".join(f"{b:02x}" for b in FPGA_MAC),
                src=target_mac,
                type=0x88B5  # Experimental EtherType
            ) / Raw(load=payload)
            
            sendp(frame, iface=found_iface, verbose=False)
            print(f"Pattern {i}: {pattern_names[i]}")
            print(f"  Data: {payload[:10].hex()}...")
            print(f"  --> Check LEDs now! (LED 0-2 = class)")
            
            # Wait for user to observe LEDs
            input("  Press Enter to send next pattern...")
            print()
        
        print("Done! You should have seen different LED patterns.")
        
    except ImportError:
        print("scapy not installed. Install with: pip install scapy")
        print("\nAlternative: Install npcap and run as Administrator")

if __name__ == "__main__":
    main()
