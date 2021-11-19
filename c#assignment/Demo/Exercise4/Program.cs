namespace Exercise4
{
    public class ArmstrongNumbers
    {
        int FirstValue, SecondValue;
        public void GetData()
        {
            Console.WriteLine("Enter FirstValue value");
        
            Int32.TryParse(Console.ReadLine(), out FirstValue);
            Console.WriteLine("Enter SecondValue value");
        
            Int32.TryParse(Console.ReadLine(), out SecondValue);

        }
        public void showArmstrongNumbers()
        {
            for (int i=FirstValue;i<=SecondValue;i++)
            {
                isArmstrongNumbers(i);
            }

        }
        public void isArmstrongNumbers(int input)
        {
            
            int b = input;
            int check = 0,last=0;
            while (b > 0)
            {
                last = b % 10;

                check = check + (last*last*last);
                b = b / 10;
            }



            if (check==input) 
            {
                Console.WriteLine(""+input);
            }
            
        }

    }

    class Program
    {
        static void Main(string[] args)
        {
            ArmstrongNumbers a1 = new();
            a1.GetData();
            a1.showArmstrongNumbers();
           
            Console.ReadKey();
        }
    }
}