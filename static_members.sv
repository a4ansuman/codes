// Static Class Members in OOP
// Reference: https://verificationguide.com/systemverilog/systemverilog-static-class-members/
// Concept:
// A class can have static properties and static methods (functions and tasks), a single copy of static variables is shared across multiple instances.
// ***Static Properties***
// The class can have multiple instances (objects), each instance (object) of the class will be having its own copy of variables.
// Sometimes only one version of a variable is required to be shared by all instances. These class properties are created using the keyword static.
// ***Static Methods***
// A static method can access only static properties of the class and access to the non-static properties is illegal and lead to a compilation error.
// ***Rules for Static Class Members***
// * Static members can be accessed "anywhere" using class name followed by scope resolution operator For Ex. class_name::static_mem
// * Static class properties and methods can be used without creating an object of that type.
// * Static member functions do not have this pointer.
// * Static member function can not be declared const, volatile, or const volatile or virtual.
// * Static member function declarations with the same name and the name arguments-type-list cannot be overloaded.


module test;
  class static_members;
    int a;
    static int b;
  
    static function void set(int x, int y);
      // this.a = x;	// ERROR: Unresolved reference to 'this'.
      // this.b = y;	// ERROR: Unresolved reference to 'this'.
      // a = x;			// ERRORS: 1. Illegal to access non-static property 'a' from a static method. 2. Unresolved reference to 'this' for non-static field 'a'.
      b = y;
    endfunction : set
    
    virtual function void print();
      $display("a = %0d", a);
      $display("b = %0d", b);
    endfunction : print
    
  endclass : static_members
  class child_one extends static_members;
    function new();
      a++;
      b++;
    endfunction : new
    
  endclass : child_one
  class child_two extends static_members;
    function new();
      a++;
      b++;
    endfunction : new
    
  endclass : child_two
  static_members e;
  child_one c1;
  child_one c2;
  
  initial begin
    e = new();   
    $display("***Setting values***");
    e.set(1,1);
    e.print();
    c1 = new();
    $display("***Print for child 1***");
    c1.print();		// static data member 'b' is shared by all classes
    c2 = new();
    $display("***Print for child 2***");
    c2.print();		// we observe 'a' increments only once but 'b' is incremented twice as it shared across all classes
  end
  
endmodule : test
