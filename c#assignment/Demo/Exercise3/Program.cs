namespace Exercise3
{
    public class reverseString
    {
        string s1;
        public void GetData()
        {
            Console.WriteLine("Enter your String");
            s1 = Console.ReadLine();
            
        }

        public void reverse()
        {
            String s2 = "";
            for (int i=s1.Length-1;i>=0;i--)
            {
                s2=s2+s1[i]; 
            }
            Console.WriteLine(s2);
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            reverseString s1 = new();
            s1.GetData();
            s1.reverse();
            Console.ReadKey();
        }
    }
}