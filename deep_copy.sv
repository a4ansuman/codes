// Deep copy in OOP

module test;
  
  class packet;
	int id;
	function void print();
      $write("packet class :: print -> ");
      $display("id = %0d", id);
	endfunction
endclass : packet
  
class eth_pkt;
  	bit [7:0] data;
    // why new? - we need to create object of another class, we cannot simply create NULL reference
    // if no new called, ERROR: ** Fatal: (SIGSEGV) Bad handle or reference.
  	packet pkt; // data object member
  
    function new();
    	pkt = new();
    endfunction : new
	function  void print();
        $write("eth_pkt class :: print -> ");
        $display("data  = %0d", data);
		pkt.print();
	endfunction : print
  
  function void deep_copy(eth_pkt epkt);
    	this.data = epkt.data;
    	this.pkt.id = epkt.pkt.id;
  endfunction : deep_copy
  
endclass : eth_pkt
  // create class handles/references not objects
  eth_pkt epkt1, epkt2, epkt3;
  // driver code
  initial begin
      epkt1 = new();
	  epkt1.data   = 10;
	  epkt1.pkt.id = 10;
      $display("Print before Shallow copy!");
	  epkt1.print();
	  // perform shallow copy
      // epkt2 object variable of class type eth_pkt (in this case both are handles of same class but they can be different)
      epkt2 = new epkt1;
      epkt1.pkt.id = 20;
      epkt1.data  = 20;
      $display("Print After Shallow copy!");
      epkt2.print();		// data = 10 as epkt2 holds base address of epkt1.data
	  // perform deep copy
      epkt3 = new();
      epkt1.pkt.id = 30;
      epkt1.data  = 30;
      epkt3.deep_copy(epkt1);
      $display("Print After deep copy!");
      epkt3.print(); // id = 30 as epkt3 holds base address pointer of epkt1
  end
endmodule : test
