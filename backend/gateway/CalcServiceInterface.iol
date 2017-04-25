type op: void {
  .a[1,1]:int
  .b[1,1]:int
  .key[1,1]:string
}

type t0: string{
 .key:string 
}

interface CalcServiceInterface {
 OneWay:
 RequestResponse:
   mock(t0)(string),
   div(op)(double),
   divanddouble(op)(double),
   sumanddouble(op)(double),
   sum(op)(double),
   sub(op)(double),
   subanddouble(op)(double)
}

outputPort CalcServiceCalcService{
  Location:"socket://localhost:2002/!/Service1"
  Protocol:sodep
  Interfaces: CalcServiceInterface
}