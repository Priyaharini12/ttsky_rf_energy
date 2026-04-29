<!---

This file is used to generate your project datasheet.
-->

## 🔋 How it works

This project implements a **RF Energy Harvesting Smart Power Management SoC**.

It monitors incoming RF energy (8-bit input) and classifies it into 4 levels:
- No Energy
- Low Energy
- Medium Energy
- High Energy

Based on this, a **Power FSM (Finite State Machine)** dynamically controls system behavior:

- In low energy → system enters power-saving modes
- In medium energy → sensors and display are partially enabled
- In high energy → full system (ESP32 + OLED + sensors) is active
- In no energy → system goes into sleep mode

Additional blocks:
- **Energy Predictor** detects rising/stable energy trends
- **Duty Cycle Controller** adjusts system activation based on energy level
- **Power Gating Unit** enables/disables modules for power saving
- **Task Scheduler** manages ESP32 tasks like sensing, display update, and transmission

This enables an intelligent ultra-low-power system suitable for ambient RF energy environments.

---

## ⚙️ How to test

The design is tested using a cocotb-based testbench.

### Test procedure:
1. Apply reset
2. Provide different RF energy values:
   - 0 → No energy
   - 20–40 → Low energy
   - 50–70 → Medium energy
   - 80–100 → High energy
3. Observe outputs:
   - `esp32_power`
   - `oled_power`
   - `sensor_power`
   - `sleep_mode`

### Expected behavior:
- Low energy → OLED only active
- Medium energy → sensors + OLED active
- High energy → full system ON
- No energy → sleep mode activated

Random RF fluctuations are also tested to simulate real-world RF noise conditions.

---

## 🔌 External hardware

This project is designed for simulation in Tiny Tapeout Sky130 and does not require mandatory external hardware.

However, it is conceptually designed for integration with:

- ESP32 microcontroller (power gating control)
- OLED display module (I2C display output)
- RF antenna (copper wire antenna for energy harvesting)
- Energy harvesting front-end (diode + capacitor + boost converter in real implementation)

---
