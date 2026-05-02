<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>UART Transceiver Project</title>

<style>
:root {
    --primary: #0f4c81;
    --secondary: #1a73e8;
    --bg: #f5f7fa;
    --card: #ffffff;
}

body {
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
    background: var(--bg);
    color: #333;
}

/* Container */
.container {
    max-width: 1000px;
    margin: auto;
    padding: 20px;
}

/* Hero */
.hero {
    background: linear-gradient(135deg, #0f4c81, #1a73e8);
    color: white;
    padding: 40px;
    border-radius: 12px;
    text-align: center;
}

.hero h1 {
    margin: 0;
    font-size: 2.5em;
}

.hero p {
    opacity: 0.9;
}

/* Sections */
.section {
    background: var(--card);
    margin-top: 20px;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.05);
}

.section h2 {
    color: var(--secondary);
}

/* Grid */
.grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 15px;
}

/* Cards */
.card {
    background: #eef4ff;
    padding: 15px;
    border-radius: 8px;
    text-align: center;
}

/* Badge */
.badge {
    display: inline-block;
    background: #e8f0fe;
    padding: 5px 10px;
    margin: 5px;
    border-radius: 6px;
    font-size: 0.9em;
    color: #0f4c81;
}

/* Footer */
.footer {
    text-align: center;
    margin-top: 30px;
    color: #777;
}
</style>
</head>

<body>

<div class="container">

<!-- HERO -->
<div class="hero">
    <h1>🚀 UART Transceiver (FPGA)</h1>
    <p>High-Performance RTL Design with FWFT FIFO Buffering</p>
    <p><strong>By Siddharth Gautam</strong></p>

    <div>
        <span class="badge">Verilog</span>
        <span class="badge">FPGA</span>
        <span class="badge">UART</span>
        <span class="badge">Vivado</span>
    </div>
</div>

<!-- OVERVIEW -->
<div class="section">
<h2>📌 Overview</h2>
<p>
This project presents a high-performance UART transceiver designed at the RTL level.
It includes parameterized TX/RX modules, FIFO buffering, metastability protection,
and mid-bit sampling for reliable asynchronous communication.
</p>
</div>

<!-- FEATURES -->
<div class="section">
<h2>✨ Key Features</h2>
<ul>
<li>FWFT FIFO for high-speed burst transfers</li>
<li>Mid-bit sampling for reliable RX</li>
<li>Two-stage synchronizer for metastability protection</li>
<li>Fully parameterized design</li>
</ul>
</div>

<!-- ARCHITECTURE -->
<div class="section">
<h2>📐 Architecture</h2>
<p>
The system uses separate FSMs for TX and RX. The transmitter converts parallel data
to serial format, while the receiver reconstructs incoming bits using precise timing.
FIFO buffers decouple system speed from serial communication.
</p>
</div>

<!-- PERFORMANCE -->
<div class="section">
<h2>📊 Performance</h2>

<div class="grid">
    <div class="card">
        <h3>+6.203 ns</h3>
        WNS
    </div>

    <div class="card">
        <h3>+0.092 ns</h3>
        WHS
    </div>

    <div class="card">
        <h3>100 MHz</h3>
        Clock
    </div>

    <div class="card">
        <h3>115200 bps</h3>
        Baud Rate
    </div>
</div>

</div>

<!-- POWER -->
<div class="section">
<h2>⚡ Power</h2>
<ul>
<li>Total Power: 0.072 W</li>
<li>Dynamic Power: 0.002 W</li>
<li>Highly optimized switching activity</li>
</ul>
</div>

<!-- FUTURE -->
<div class="section">
<h2>🚀 Future Work</h2>
<ul>
<li>AXI4-Lite integration</li>
<li>RS-485 / RS-232 interface</li>
<li>DMA-based transfer</li>
</ul>
</div>

<!-- FOOTER -->
<div class="footer">
<p>© 2026 Siddharth Gautam | FPGA & Embedded Systems</p>
</div>

</div>

</body>
</html>