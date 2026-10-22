#ifndef MC_BUILD_PROFILE_H
#define MC_BUILD_PROFILE_H

#ifndef MC_BUILD_REV
#define MC_BUILD_REV 0UL /* manual build; scripted profiles embed the source revision */
#endif
#ifdef MC_ENABLE_CAN_FAULTS
#define MC_BUILD_CAN_FAULTS 1U
#else
#define MC_BUILD_CAN_FAULTS 0U
#endif
#ifdef MC_ENABLE_CAN_RAW_GPIO
#define MC_BUILD_CAN_RAW_GPIO 1U
#else
#define MC_BUILD_CAN_RAW_GPIO 0U
#endif

#ifdef MC_ENABLE_CAN_LIVE
#define MC_BUILD_CAN_LIVE 1U
#else
#define MC_BUILD_CAN_LIVE 0U
#endif

#endif
