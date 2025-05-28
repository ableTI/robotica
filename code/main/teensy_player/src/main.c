#include <zephyr/kernel.h>
#include <zephyr/device.h>
#include <zephyr/drivers/gpio.h>
#include <zephyr/sys/printk.h>
#include <zephyr/sys/__assert.h>
#include <string.h>

/* size of stack area used by each thread */
#define STACKSIZE 1024

/*the pinout configuration*/
/*https://docs.zephyrproject.org/latest/boards/pjrc/teensy4/doc/index.html*/
/*motors pins*/
#define m1enA DT_ALIAS(GPIO2_10)    /*pin 6*/
#define m1enB DT_ALIAS(GPIO4_8)     /*pin 5*/
#define m1pwm1 DT_ALIAS(GPIO4_6)    /*pin 4*/
#define m1pwm2 DT_ALIAS(GPIO4_5)    /*pin 3*/
/*encoder pins*/
#define m1encoA DT_ALIAS(GPIO2_12)  /*pin 32*//*encoder number 1*/
#define Nm1encoA INT_TO_POINTER(0)    /*gives encoder number N*/
#define m1encoB DT_ALIAS(GPIO3_22)  /*pin 31*//*encoder number 2*/
#define Nm1encoB INT_TO_POINTER(1)    /*gives encoder number N*/


/*set priorities*/
#define ENC_ISR_PRIO 1 /* set encoder interrupt service routine*/


void ENCO_ISR(void *encN){
    if (encN == 0){

    }

}


void ENC_ISR_installer(void)
{
    /*sets up the interupts for the encoder at same priority, need to configure FIFO in case of simultanius call*/
    IRQ_CONNECT(MY_DEV_IRQ, ENC_ISR_PRIO, m1encoA_ISR, Nm1encoA, MY_IRQ_FLAGS);
    IRQ_CONNECT(MY_DEV_IRQ, ENC_ISR_PRIO, m1encoB_ISR, Nm1encoB, MY_IRQ_FLAGS);
}
