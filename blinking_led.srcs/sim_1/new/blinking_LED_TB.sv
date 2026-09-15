`timescale 1ns / 1ps

module blinking_LED_TB();

    // Internal Signals
    logic led_en;
    logic sysclk;
    logic rst;
    logic led_out;
    
    // Instantiate blinking_led.sv design source
    blinking_led #(.CLK_CYCLE_PER_TOGGLE(1)) DUT
        (
            .led_en(led_en),
            .sysclk(sysclk),
            .rst(rst),
            .led_out(led_out)
        );
        
    // Set Clock Toggle Time
    always
        begin
            #5 sysclk = ~sysclk;
        end
    
    // Test Cases
    initial
        begin
        
            // Beginning
            sysclk = 0;
            rst = 1;
            led_en = 0;
            #20
            
            // Test Case 1: Reset OFF, LED disabled
            rst = 0;
            led_en = 0;
            #10;

            // Test Case 2: Enable LED and allow counter to run
            rst = 0;
            led_en = 1;
            #10;

            // Test Case 3: Disable LED
            led_en = 0;
            #10;

            // Test Case 4: Enable LED again
            led_en = 1;
            #10;

            // Test Case 5: Press reset
            rst = 1;
            #20;

            // Test Case 6: Release reset and enable LED
            rst = 0;
            led_en = 1;
            #10;
            
            $finish;
        end
            
endmodule
