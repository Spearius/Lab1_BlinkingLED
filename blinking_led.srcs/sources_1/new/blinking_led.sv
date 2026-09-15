`timescale 1ns / 1ps
// This program is designed to set a standard clock toggle rate of 62,500,000.
// Then it has one led that blinks every clock cycle.

module blinking_led #(parameter int CLK_CYCLE_PER_TOGGLE = 62_500_000)
    (
        input logic led_en,
        input logic sysclk,
        input logic rst,
        
        output logic led_out
    );
    
    logic [$clog2(CLK_CYCLE_PER_TOGGLE) - 1:0] counter;     // Sets the bit width (26-bits) for the clock toggle rate
    
    always_ff @(posedge sysclk)
        begin
            if (counter == CLK_CYCLE_PER_TOGGLE - 1)
                begin
                    led_out <= ~led_out;    // Toggles LED0, not power it OFF
                    counter <= 0;
                end
                
            else if ((rst == 1) || (led_en == 0))
                begin
                    counter <= 0;
                    led_out <= 0;   // Powers LED OFF, not toggle
                end
            
            else
                begin
                    counter <= counter + 1;
                end
        end
        
endmodule
