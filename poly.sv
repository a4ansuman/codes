module test;
  	class parent;
  	virtual function void print();
    		$display("parent class");
  	endfunction : print
	endclass : parent

	class child extends parent;
 	 virtual function void print();
   	 	$display("child class");
 	 endfunction : print
	endclass : child
    // create handles (pointers) of both classes
    parent p, p1; 
    child c, c1;
    // Inheritance
    initial begin
    $display("CASE I: Inheritance");
      p = new();
      c = new();
    p.print();
    c.print();
    end
    // Polymorphism
    initial begin
    $display("CASE II: Polymorphism");
    c = new();
    p = c;		// shallow copy assign child to parent
    p.print(); 	// if print method is declared virtual, "child class" is printed else "parent class" is printed.
    c.print();
    $display("******************************");
    end
    // Dynamic typecasting when downcast is required
    initial begin
    $display("CASE III: Why we need to use dynamic typecasting!");
    c = new();
    /*
    // c1 = p;// if we write c1 = p => compilation error even though parent handle is pointing to child object.
    // to overcome this issue, we need casting.
    // ERROR:  Illegal assignment to type 'class testbench_sv_unit.child' from type 'class testbench_sv_unit.parent': 
    // Types are not assignment compatible.
    // p = c; // works fine
    // p = c -> if function definition is non-virtual, compile time definition of parent object p
    // p = c -> else if function definition is virtual, run time definition of child object c
    // c = p; // incompatible types
    //c = new p; // RUNTIME FATAL error
	*/
    // FIX: use casting
    if($cast(p,c)) begin // write a check to call $cast system task as a function
      p.print();
      c.print();
    end
      $display("******************************");
    end
endmodule
© 2021 GitHub, Inc.