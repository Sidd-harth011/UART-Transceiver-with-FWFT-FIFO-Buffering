# 🚀 High-Performance UART Transceiver (FPGA)

**Developed by:** Siddharth Gautam  

---

## 📌 Overview
This project presents a high-performance UART (Universal Asynchronous Receiver-Transmitter) transceiver designed at the RTL level using Verilog.  
The architecture integrates FIFO buffering, metastability protection, and precise mid-bit sampling for reliable asynchronous communication.

The design has been verified through simulation and successfully achieves timing closure at a **100 MHz system clock**.

---

## ✨ Key Features
- 🔹 **FWFT FIFO Buffers**  
  First-Word Fall-Through FIFOs decouple high-speed system logic from slower serial communication.

- 🔹 **True Mid-Bit Sampling**  
  Ensures accurate data reception without relying on a global baud clock.

- 🔹 **Metastability Protection**  
  Two-stage synchronizers safeguard against asynchronous input hazards.

- 🔹 **Parameterized Design**  
  Easily configurable for different clock frequencies and baud rates.

---

## 📐 Architecture
The UART system is divided into two independent modules:

### 🔸 Transmitter (TX)
- Reads parallel data from TX FIFO  
- Converts data into serial format  
- Adds start and stop bits  
- Operates using baud-rate timing  

### 🔸 Receiver (RX)
- Detects start bit  
- Performs mid-bit sampling  
- Reconstructs serial data into parallel format  
- Stores received data into RX FIFO  

---

## 🔬 Verification & Simulation
- Simulated using **Xilinx Vivado**
- Custom testbench developed for:
  - Burst data injection (`A1, B2, C3, D4`)
  - Continuous transmission  

### ✅ Verified:
- Correct framing  
- Accurate mid-bit sampling  
- FIFO-based data handling  

---

## 📊 Performance Metrics

| Metric | Value |
|--------|------|
| Clock Frequency | 100 MHz |
| Max Baud Rate | 115200 bps |
| Worst Negative Slack (WNS) | +6.203 ns |
| Worst Hold Slack (WHS) | +0.092 ns |

---

## ⚡ Power Consumption
- **Total Power:** 0.072 W  
- **Dynamic Power:** 0.002 W  
- Optimized for low switching activity  

---

## 🧪 Testing & Validation
- Loopback testing (TX → RX)  
- Stress testing with continuous transmission  

### Results:
- No framing errors  
- No data corruption  
- Stable high-speed operation  

---

## 🚀 Future Enhancements
- AXI4-Lite interface integration  
- RS-485 / RS-232 hardware interface  
- DMA-based data transfer  
- Multi-device communication  

---

## 🛠️ Tech Stack
- **Language:** Verilog  
- **Tools:** Vivado  
- **Domain:** FPGA / Digital Design  

---

## 📷 Results (Add Screenshots)
> Add waveform and timing screenshots here

---

## 📎 Repository Link
> Add your GitHub repo link here

---

## 🧠 Learning Outcomes
- RTL design of communication protocols  
- Handling asynchronous systems  
- FIFO-based buffering  
- Timing analysis and FPGA implementation  

---

## ⭐ Support
If you like this project, give it a ⭐ on GitHub!