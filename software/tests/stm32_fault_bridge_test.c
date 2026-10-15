#include <assert.h>

#include "../src/stm32_fault_bridge.h"
#include "../../stm32_f407/common/include/mc_faults.h"

int main(void)
{
    unsigned int i;
    ErrorCode mapped = ERROR_SPI_PARTIAL_BYTE;
    assert((unsigned int)MC_FAULT_COUNT == (unsigned int)ERROR_CODE_COUNT);
    for (i = 0U; i < (unsigned int)MC_FAULT_COUNT; ++i) {
        const mc_fault_info_t *fault = mc_fault_get((mc_fault_id_t)i);
        assert(fault != 0);
        assert(stm32_fault_case_to_error(fault->case_id, &mapped));
        assert((unsigned int)mapped == i);
    }
    assert(mc_fault_get(MC_FAULT_COUNT) == 0);
    return 0;
}
