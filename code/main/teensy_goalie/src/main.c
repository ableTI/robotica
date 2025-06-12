#include <stdio.h>
#include <zephyr/kernel.h>
#include <zephyr/sys/printk.h>
#include <zephyr/device.h>
#include <zephyr/drivers/pwm.h>
#include <zephyr/devicetree.h>
#include <zephyr/drivers/gpio.h>

// Settings
#define PWM_PERIOD_NS 20000000
#define PWM_PULSE_WIDTH 1400000
static const int32_t sleep_time_ms = 100;
static const struct gpio_dt_spec btn = GPIO_DT_SPEC_GET(DT_ALIAS(powerswitch), gpios);
static const struct gpio_dt_spec led = GPIO_DT_SPEC_GET(DT_ALIAS(redled), gpios);

#define LED0_NODE DT_ALIAS(redled)
#define PWM_LED0 DT_ALIAS(en3a)
