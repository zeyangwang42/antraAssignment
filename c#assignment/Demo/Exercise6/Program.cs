
namespace Exercise6
{
    public class Diamond
    {

        int NoRow;
        public void GetData()
        {
            Console.WriteLine("Enter the Number of Rows: ");
            Int32.TryParse(Console.ReadLine(), out NoRow);
        }

        public void print()
        {

       
            for (int i = 0; i < NoRow; i++)
            {
                for (int j = 0; j < NoRow-i-1; j++)
                {
                    Console.Write(" ");
                }
                for (int j = 0; j < i*2+1; j++)
                {
                    Console.Write("*");
                }
                Console.Write("\n");
            }
            for (int i = 1; i < NoRow; i++)
            {
                for (int j = 0; j <i; j++)
                {
                    Console.Write(" ");
                }
                for (int j = 0; j < NoRow*2-1-i * 2; j++)
                {
                    Console.Write("*");
                }
                Console.Write("\n");
            }


        }



        }
    

    class Program
    {
        static void Main(string[] args)
        {
            Diamond d1 = new();
            d1.GetData();
            d1.print();
            Console.ReadKey();
        }
    }
}