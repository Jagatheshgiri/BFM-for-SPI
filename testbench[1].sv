module spi_tb;
   parameter int clk_rate = 400000;
   time		 period = 1s/clk_rate;

   wire		 sclk;
   wire		 mosi;
   wire		 miso;
   wire		 ss;

   // Read output
   logic [15:0] wr_data = 16'hA5A5;
   logic [15:0] rd_data;


   initial begin
      // Writes
      dut_master.m_write_data(.wr_data(wr_data), .rd_data(rd_data));
      repeat(10) #(period);
      dut_master.m_write_data(.wr_data(16'hABCD), .rd_data(rd_data));

      $display("============================");
      $display("======= TEST PASSED! =======");
      $display("============================");
 #600 $finish;
   end


   initial begin
      #(1000*period)

      $display("============================");
      $display("======= TEST FAILED! =======");
      $display("============================");
      $finish;
   end
  
    
  initial begin
  $dumpfile("dump.vcd");
  $dumpvars(0);
  end


   // DUTs
   spi_master_bfm #(.clk_polarity(0), .clk_phase(0), .clk_freq(clk_rate)) dut_master(.sclk(sclk), .mosi(mosi), .miso(miso), .ss(ss));
   spi_slave_bfm #(.clk_polarity(0), .clk_phase(0)) dut_slave(.sclk(sclk), .mosi(mosi), .miso(miso), .ss(ss));
endmodule // spi_tb
