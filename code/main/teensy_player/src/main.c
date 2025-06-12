#include <zephyr/kernel.h>
#include <zephyr/device.h>
#include <zephyr/drivers/gpio.h>
#include <zephyr/sys/printk.h>
#include <zephyr/sys/__assert.h>
#include <zephyr/drivers/uart.h>
#include <zephyr/drivers/pwm.h>
#include <string.h>

/* Stack sizes (now only one size)*/
/* To figure out how much is necessary: */
/* https://zephyr-docs.listenai.com/guides/debug_tools/thread-analyzer.html */
#define GENERAL_THREAD_STACKSIZE 1024

/*the pinout configuration*/
/*https://docs.zephyrproject.org/latest/boards/pjrc/teensy4/doc/index.html*/
/*motors pins*/
#define m1enA DT_ALIAS(GPIO2_10)    /*pin 6*//*Motor 1 EN A*/
#define m1enB DT_ALIAS(GPIO4_8)     /*pin 5*//*Motor 1 EN B*/
#define m1pwm1 DT_ALIAS(GPIO4_6)    /*pin 4*/
#define m1pwm2 DT_ALIAS(GPIO4_5)    /*pin 3*/
/*encoder pins*/
#define m1encoA 32  /*pin 32   &&   encoder number 0*/
#define Nm1encoA INT_TO_POINTER(0)
#define m1encoB 31  /*pin 31   &&   encoder number 1*/
#define Nm1encoB INT_TO_POINTER(1)

/*set priorities*/
#define ENC_ISR_PRIO 1

/*encoders/PWM/PID*/
#define NUM_ENCODERS 2     /*how many encoder pins there are*/
volatile int encCount[NUM_ENCODERS] = {0};

/*misc*/
#define NO_IRQ_FLAGS 0
#define PWM_PERIOD_µS 1600   /*The lengt of an full PWM cycle in microseconds*/

void ENCO_ISR(void *encN){
    /*adds one to the encoder where a change of state is detected*/
    int encoder = (int)(intptr_t)encN;
    if (encoder >= 0 && encoder < NUM_ENCODERS) {
        encCount[encoder]++;
    }

}

void ENC_ISR_installer(void){
    /*sets up the interrupts for the encoder at same priority, need to configure FIFO in case of simultaneous call*/
    IRQ_CONNECT(m1encoA, ENC_ISR_PRIO, ENCO_ISR, '0', NO_IRQ_FLAGS);
    IRQ_CONNECT(m1encoB, ENC_ISR_PRIO, ENCO_ISR, '1', NO_IRQ_FLAGS);
}

int main(void){}
