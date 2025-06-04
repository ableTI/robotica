#include <zephyr/kernel.h>
#include <zephyr/device.h>
#include <zephyr/drivers/gpio.h>
#include <zephyr/sys/printk.h>
#include <zephyr/sys/__assert.h>
#include <zephyr/drivers/uart.h>
#include <zephyr/drivers/pwm.h>
#include <string.h>

/* size of stack area used by each thread */
#define GEN_THRESD_STACKSIZE 1024

/*the pinout configuration*/
/*https://docs.zephyrproject.org/latest/boards/pjrc/teensy4/doc/index.html*/
/*motors pins*/
#define m1enA DT_ALIAS(GPIO2_10)    /*pin 6*//*Motor 1 EN A*/
#define m1enB DT_ALIAS(GPIO4_8)     /*pin 5*//*Motor 1 EN B*/
#define m1pwm1 DT_ALIAS(GPIO4_6)    /*pin 4*/
#define m1pwm2 DT_ALIAS(GPIO4_5)    /*pin 3*/
/*encoder pins*/
#define m1encoA 32  /*pin 32*//*encoder number 1*/
#define Nm1encoA INT_TO_POINTER(0)    /*gives encoder number N*/
#define m1encoB 31  /*pin 31*//*encoder number 2*/
#define Nm1encoB INT_TO_POINTER(1)    /*gives encoder number N*/


/*set priorities*/
#define ENC_ISR_PRIO 1 /* set encoder interrupt service routine*/


/*variables*/
/*encoders/PWM/PID*/
#define NUM_ENCODERS 2     /*how many encoder pins there are*/
volatile int encCount[NUM_ENCODERS] = {0};  /*sets all encoder counts to 0 changes of state*/

/*misc*/
#define MY_IRQ_FLAGS 0       /*no IRQ flags*/

void ENCO_ISR(void *encN){
    /*adds one to the encoder where a change of state is detected*/
    int encoder = (int)(intptr_t)encN;
    if (encoder >= 0 && encoder < NUM_ENCODERS) {
        encCount[encoder]++;
    }

}

void ENC_ISR_installer(void){
    /*sets up the interupts for the encoder at same priority, need to configure FIFO in case of simultaneous call*/
    IRQ_CONNECT(m1encoA, ENC_ISR_PRIO, ENCO_ISR, '0', MY_IRQ_FLAGS);
    IRQ_CONNECT(m1encoB, ENC_ISR_PRIO, ENCO_ISR, '1', MY_IRQ_FLAGS);
}

int main(void){}
