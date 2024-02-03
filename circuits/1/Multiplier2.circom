pragma circom 2.0.0;

/*This circuit template checks that c is the multiplication of a and b.*/  

template Multiplier2 () {  

   // Declaration of signals.  
   signal input a[1];  
   signal input b[1];  
   signal output c[1];  

   signal x[1];  
   signal y[1];  

   x[0] <== a[0] + 1;
   y[0] <== b[0] * 2;
   // Constraints.  
   c[0] <== x[0] * y[0];  
}

 component main = Multiplier2();