/*
Notes on Casting:
Upcasting is parent to child type assignment and its legal
Downcasting is child to parent type assignment and it is NOT legal in OOP
Hence, we need to explicitly perform a run-time (dynamic) typecasting check to ensure
that both the object handles on LHS and RHS are of same type using $cast(dest, src) system task in SV
Same type in classes means they belong to the same class hierarchy
Ex: class Animal has child classes like dog, cat, bird
but it cannot have a unrelated child class like car or food as these are not related to animals
But how it needs appears in real Verification test bench?
Usually our TB env is complex with handles to classes of various types
and to make sure that the class handles on LHS and RHS are compatible we need to use $cast()
This ensures that we avoid a compilation error as $cast() froces the check to happen at run-time
*/
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
    p.print(); 		// if print method is declared virtual, "child class" is printed else "parent class" is printed.
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
