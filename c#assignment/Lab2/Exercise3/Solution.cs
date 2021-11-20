using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exercise3
{
     class Solution
    {

        public int solution(int A, int B)
        {
            int start = 0;
            int result = 0;
            while (start<=100)
            {
                if ((start*start)>=A&& (start * start) <= B)
                {
                    result++;
                }
                start++;
            }
            return result;
        }
        static void Main(string[] args)
        {
           Solution s = new ();
            int A, B;
            Console.WriteLine("Please enter A value");
            Int32.TryParse(Console.ReadLine(),out A);
            Console.WriteLine("Please enter A value");
            Int32.TryParse(Console.ReadLine(), out B);
            Console.WriteLine("RESULT IS: "+s.solution(A, B));    
            Console.ReadLine();
        }
    }
}
