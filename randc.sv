module test;
class randc_test;
rand bit [1:0] data;
bit [7:0] q[$];

   constraint value_c {
     !(data inside {q});
    }
 
     function void post_randomize();
       //for(int i=0;i<25;i++) begin
       q.push_back(data);
       //if the size equals to the number of all combinations, clear the queue
       if(q.size() == 4)
          begin
            q = {};
          end 
       //end     
     endfunction

endclass
  
randc_test rc_t;

initial begin

    rc_t = new();

  repeat(100) begin
    if(rc_t.randomize())
      $display("%p",rc_t.q);
    end
end
endmodule
