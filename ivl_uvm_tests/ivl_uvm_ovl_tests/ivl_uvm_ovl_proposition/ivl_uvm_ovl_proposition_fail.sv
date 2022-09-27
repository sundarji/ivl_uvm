`timescale 1ns/1ns

module test;

   wire clk;
   wire bus_grant;
   reg current_adr;
   reg adr;
   reg reset;
   reg enable;

   // Check wr_val is not same as wr_done
   ovl_proposition #(`OVL_ERROR,`OVL_ASSERT,"error in ovl_proposition detection",`OVL_COVER_ALL) valid_address(reset,enable,current_adr==adr,bus_grant);

   initial begin
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(1, test);

      // Initialize values.
  $display("\n initial values of bus_grant=%0d , current_adr=%0d ,adr=%0d \n",bus_grant,current_adr,adr);
  reset=0;
  enable=0;
     
      current_adr = 0;
      adr = 0;
			

      $display("making grant high \n");
      
      wait_clks(5);
	  enable=1;
	  reset=1;
     

    $display("\n values of bus_grant=%0d , current_adr=%0d ,adr=%0d \n",bus_grant,current_adr,adr);

      wait_clks(5);
     current_adr=0;

 $display("\n  values of bus_grant=%0d , current_adr=%0d ,adr=%0d \n",bus_grant,current_adr,adr);
      wait_clks(5);
       adr=1;
 $display("\n  values of bus_grant=%0d , current_adr=%0d ,adr=%0d \n",bus_grant,current_adr,adr);

$display("\n now assertion should kick in \n");

       wait_clks(10);

      $finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule


