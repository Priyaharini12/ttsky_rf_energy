import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def rf_energy_test(dut):

    dut._log.info("Starting RF Energy Harvesting SoC Test")

    # Reset
    dut.reset.value = 1
    dut.rf_energy.value = 0
    await Timer(20, units="ns")
    dut.reset.value = 0

    # Phase 1: No energy
    dut.rf_energy.value = 0
    await Timer(50, units="ns")

    # Phase 2: Low energy
    dut.rf_energy.value = 25
    await Timer(50, units="ns")

    # Phase 3: Medium energy
    dut.rf_energy.value = 60
    await Timer(50, units="ns")

    # Phase 4: High energy
    dut.rf_energy.value = 90
    await Timer(50, units="ns")

    # Random stress test
    for i in range(10):
        dut.rf_energy.value = (i * 13) % 100
        await Timer(10, units="ns")

    dut._log.info("Test completed")
