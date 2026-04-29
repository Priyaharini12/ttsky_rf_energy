import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def rf_energy_test(dut):

    dut._log.info("Starting RF Energy Harvesting SoC Test")

    # Reset (active low in Tiny Tapeout)
    dut.rst_n.value = 0
    dut.ui_in.value = 0
    await Timer(20, units="ns")
    dut.rst_n.value = 1

    # Phase 1: No energy
    dut.ui_in.value = 0
    await Timer(50, units="ns")

    # Phase 2: Low energy
    dut.ui_in.value = 25
    await Timer(50, units="ns")

    # Phase 3: Medium energy
    dut.ui_in.value = 60
    await Timer(50, units="ns")

    # Phase 4: High energy
    dut.ui_in.value = 90
    await Timer(50, units="ns")

    # Noise test
    for i in range(10):
        dut.ui_in.value = (i * 17) % 100
        await Timer(10, units="ns")

    dut._log.info("Test completed successfully")
