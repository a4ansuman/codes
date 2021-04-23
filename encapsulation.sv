/*
NOTE: uncomment the code lines to see errors for incorrect usage

Data hiding and Encapsulation in OOP
Reference: https://verificationguide.com/systemverilog/systemverilog-data-hiding-encapsulation/
Concept:
The technique of hiding the data within the class and making it available only through the methods, is known as encapsulation.
Thus it seals the data (and internal methods) safely inside the “capsule” of the class, where it can be accessed only by trusted users  (i.e., by the methods of the class).
***Access Control***
By default all the members and methods of a class are accessible from anywhere using the object handle, sometimes this could corrupt the class members values, 
which should not be touched at all.
Access control rules that restrict the members of a class from being used outside the class, this is achieved by prefixing the class members with the keywords,
1. local: External access to the class members can be avoided by declaring members as local. Any violation could result in a compilation error.
2. protected: In some use cases, it is required to access the class members only by the derived class’s, 
   this can be done by prefixing the class members with the protected keyword. Any violation could result in a compilation error.
****But how does this help in real world Verification?
1. As mentioned above, by default all the class data members, constraints and  data member functions are accessible from anywhere using the object handle, 
   sometimes this could corrupt the class members values, which should not be touched at all. 
2. If the requirements demands access to a class data members (properties) or data member functions or  constraints MUST be limited to a local scope (use 'local' only for that member) 
   or only the child classes (use 'protected' only for that member)
*/

module test;
  class encapsulation;
    int a;
    local int b;
    protected int c;
    
    // data members can be accessed by calling the member functions after creating the object
    virtual function void set(int x, int y, int z);
      this.a = x;
      this.b = y;
      this.c = z;
    endfunction : set
    
    virtual function void print();
      $display("a = %0d", a);
      $display("b = %0d", b);
      $display("c = %0d", c);
    endfunction : print
    
  endclass : encapsulation
  
  class child extends encapsulation;
    // "setc()" is a not same as "set()" method
    virtual function void setc(int x);
      super.set(1,2,3);		// Why? What is the advantage?
      this.c = x;
    endfunction : setc
  endclass : child
  
  
  class unrelated;
    encapsulation e = new();
    // "setcc()" is a not same as "set() or setc()" method
    virtual function void setcc(int x);
      // protected data members cannnot be accessed in unrelated/uninherited class
      // e.c = x;		// ERROR: Illegal access to protected member c.
    endfunction : setcc
  endclass : unrelated
  
  // create class handle
  encapsulation e;
  child c;
  unrelated u;
  
  initial begin
    // create class object
    e = new();
    c = new();
    e.a = 1;
    
    // local/protected data members cannnot be accessed outside the base class
    // e.b = 2;	// ERROR: Illegal access to local member b.
    // e.c = 3;	// ERROR: Illegal access to protected member c.
    
    $display("***Setting values***");
    e.set(1,2,3);
    e.print();
    c.setc(4);
    $display("***Setting new value for c***");
    c.print(); 
    // u.setcc(4); 	// ERROR: Illegal access to protected member c.
  end
  
endmodule : test
