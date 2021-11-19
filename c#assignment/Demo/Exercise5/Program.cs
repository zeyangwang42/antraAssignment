
namespace Exercise5
{
    public class binaryTriangle
    {
        
        int NoRow;
        public void GetData()
        {
            Console.WriteLine("Enter the Number of Rows: ");
            Int32.TryParse(Console.ReadLine(), out NoRow); 
        }

        public void DisplayTriangle()
        {
            
            String display = "";
            for (int i =3;i<NoRow+3;i++)
            {
                switch (i%4)
                {
                    case 0:
                        display =0+ display;
                        break;
                    case 1:
                        display = display+0;
                        break;
                    case 2:
                        display = 1 + display;
                        break;
                    case 3:
                        display = display+1;
                        break;

                } 
                Console.WriteLine(display);
            
            }



        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            binaryTriangle b1 = new();
            b1.GetData();
            b1.DisplayTriangle();
            Console.ReadKey();
        }
    }
}