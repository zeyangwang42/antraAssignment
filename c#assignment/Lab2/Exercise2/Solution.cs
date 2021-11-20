using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exercise2
{
    class Solution
    {

        public int solution(int[] A)
        {
           
            int result=A[0];
            Dictionary<int,int> dic = new Dictionary<int,int>();
            for (int i=0;i<A.Length;i++)
            {
                
                if (dic.ContainsKey(A[i]))
                {
                    dic[A[i]]= dic[A[i]]+1;
                }
                else
                {
                    dic.Add(A[i], 1);
                }
            }
            int repeat = 0;
            foreach (var a in dic.Keys) {
                if (repeat<dic[a]) {
                    repeat =dic[a];
                    result = a;
                }
            }



            return result;
        }
        

        static void Main(string[] args)
        {
            Solution s = new();
            Console.WriteLine("Please enter your array size");
            int size;
            
            Int32.TryParse(Console.ReadLine(), out size);
            int[] array = new int[size];
            for (int i = 0; i < size; i++)
            {
                Console.WriteLine("Please enter your " + (i + 1) + "th array values");
                Int32.TryParse(Console.ReadLine(), out array[i]);
            }

            if (size>0)
            {
               Console.WriteLine("most repeat value is: " +s.solution(array));
            }
            
           
        }
    }



}
