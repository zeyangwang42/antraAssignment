using System;
namespace Exercise2
{
    public class Arithmetic
    {
        int a,b;
      public void Addition()
        {
            Console.WriteLine("Addition reulut: " + (a+b));
        }
        public void subtraction()
        {
            Console.WriteLine("Subtraction reulut: " + (a - b));
        }
        public void multiplication()
        {
            Console.WriteLine("Multiplication reulut: " + (a * b));
        }
        public void division()
        {
            Console.WriteLine(" Division reulut: " + (a / b));
        }
        public void GetData()
        {
            Console.WriteLine("Enter First value");
            string input1 = Console.ReadLine();
            Int32.TryParse(input1, out a);
            Console.WriteLine("Enter Second value");
            string input2 = Console.ReadLine();
            Int32.TryParse(input2, out b);

        }

    }

    class Program
    {
        static void Main(string[] args)
        {
            Arithmetic a1 = new();
            a1.GetData();
            Console.WriteLine("Enter Arithmetic type:Addition, Subtraction, Multiplication or Division");
            string input = Console.ReadLine();

            switch (input)
            {
                case "Addition":
                    a1.Addition();
                    break;
                case "Subtraction":
                    a1.subtraction();
                    break;
                case "Multiplication":
                    a1.multiplication();
                    break;
                case "Division":
                    a1.division();
                    break;
                default:
                    Console.WriteLine($"Arithmetic type need to be :Addition, Subtraction, Multiplication and Division");
                    break;
            }
          
            Console.ReadKey();
        }
    }
}