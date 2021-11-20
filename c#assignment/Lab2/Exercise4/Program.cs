namespace Exercise4
{
    class Solution
    {

        static void Main(string[] args)
        {
            Console.WriteLine("If you want to enter a array as arr[A,B],Please enter your A size");
            int A;

            Int32.TryParse(Console.ReadLine(), out A);
            Console.WriteLine("If you want to enter a array as arr[A,B],Please enter your B size");
            int B;

            Int32.TryParse(Console.ReadLine(), out B);
            int[,]array = new int[A,B];
            for (int i = 0; i < A; i++)
            {
                for (int j = 0; j < B; j++)
                {
                    Console.WriteLine("Please enter arr[ " + i +","+j + "] values");
                    Int32.TryParse(Console.ReadLine(), out array[i,j]);
                }
                
            }
           
            int up = 0;
            int left = 0;
            int right = B - 1;
            int down = A - 1;
            int Count = 0;
            while (Count<A*B) {
                
                for (int col = left; col <= right; col++)
                {
                  
                    Console.Write(array[up,col]+" ");
                    Count++;
                }
                
                for (int row = up + 1; row <= down; row++)
                {
                    Console.Write(array[row,right]+" ");
                    Count++;
                }
                
                if (up != down)
                {
                    
                    for (int col = right - 1; col >= left; col--)
                    {
                        Console.Write(array[down,col]+" ");
                        Count++;
                    }
                }
                
                if (left != right)
                {
                    
                    for (int row = down - 1; row > up; row--)
                    {
                        Console.Write(array[row,left]+" ");
                        Count++;
                    }
                }
                left++;
                right--;
                up++;
                down--;


            }

        }
    }
}
