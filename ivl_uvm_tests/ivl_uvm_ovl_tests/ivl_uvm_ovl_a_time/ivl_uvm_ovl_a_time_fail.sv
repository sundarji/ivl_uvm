`timescale 1ns/1ns

module test;

   wire clk;
   reg bus_grant;
   reg current_adr;
   reg adr;
   reg reset;
   reg enable;
   wire [2:0]  fire;


initial begin
 // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(1, test);



end


   // Check wr_val is not same as wr_done
   ovl_time #(`OVL_ERROR,2,`OVL_RESET_ON_NEW_START,`OVL_ASSERT,"error in ovl_time detection",`OVL_COVER_ALL) valid_address(clk,reset,enable,bus_grant,current_adr==adr,fire);
   
    
   

   initial begin
     

      // Initialize values.
  $display("\n initial values of reset=%0d , bus_grant=%0d , current_adr=%0d , adr=%0d, fire=%0d \n",reset, bus_grant,current_adr,adr,fire);
     reset=0;
     enable=0;
     bus_grant=0;
	 
     current_adr = 1;
     adr = 0;
			

      $display("making grant high \n");
      
      wait_clks(5);
	  enable=1;
	  reset=1;
       bus_grant=1;
	   current_adr = 0;
        adr = 1;
	   
  $display("\n initial values of reset=%0d , bus_grant=%0d , current_adr=%0d , adr=%0d, fire=%0d \n",reset, bus_grant,current_adr,adr,fire);

     wait_clks(5);
	 

     
$display("\n now assertion should kick in \n");

       wait_clks(10);

      $finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule


