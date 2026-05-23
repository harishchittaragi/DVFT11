class test extends uvm_test;
   //calling producer_b and consumer_a classes:
   producer p_h;
   consumer c_h;
//   uvm_tlm_analysis_fifo #(transaction) fifo_con;

   `uvm_component_utils(test)

   function new(string name = "test", uvm_component parent =null);
      super.new(name,parent);
   endfunction:new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      p_h=producer::type_id :: create("p_h",this);
      c_h=consumer::type_id :: create("c_h",this);
//      fifo_con =new("fifo_con");

   endfunction:build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      p_h.send.connect(c_h.recieve.analysis_export);
//      c_h.recieve.connect(fifo_con.get_export);
   endfunction:connect_phase
endclass:test

