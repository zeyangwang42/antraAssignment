public class CAssignment
{
    public int []  repeatArray(int [] input)
    {
        int [] result = new int [input.Length*2];
        for(int i =0; i < input.Length; i++)
        {
           result [i] = input [i];
            result[i + input.Length] = input[i];
        }
        
        return result;
    }

    public static void Main()
    {

        int[] input = { 1, 2, 3 };

        CAssignment test = new();
        int [] output = test.repeatArray(input);


      

        foreach ( var nums in output)
        {

            Console.WriteLine(nums);
        }

    }


}
