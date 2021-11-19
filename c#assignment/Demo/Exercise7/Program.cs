namespace Exercise7
{
    public class ATMTransaction
    {
        private int pin = 123;
        private float Amount=1000;
        public void login()
        {
            Console.WriteLine("Enter Your Pin Number");
            int input;
            Int32.TryParse(Console.ReadLine(), out input);
            if (input == pin)
            {
                meau();
            }
            else
            {
                Console.WriteLine("WRONG PIN NUMBER");
                
            }
        }
            private void meau()
        {
                Console.WriteLine("********Welcome to ATM Service**************");
                Console.WriteLine();
                Console.WriteLine("1. Ckeck Balance");
                Console.WriteLine();
                Console.WriteLine("2. Withdraw Cash");
                Console.WriteLine();
                Console.WriteLine("3. Deposit Cash");
                Console.WriteLine();
                Console.WriteLine("4. Quit");
                Console.WriteLine();
                Console.WriteLine("*********************************************");
                Console.WriteLine("Enter your choice:");
                int input1;
                Int32.TryParse(Console.ReadLine(), out input1);

                switch (input1)
                {
                    case 1:
                        BalanceChecking();
                        break;
                    case 2:
                        WithdrawCash();
                        break;
                    case 3:
                        DepositCash();
                        break;
                    case 4:
                        Console.WriteLine("THANK YOU FOR YOUR USING");
                        return;
                    default:
                        Console.WriteLine("TYPE IN FORMAT IS NOT RIGHT");
                        break;

                }
            Console.WriteLine();
            meau();
        }


        private void BalanceChecking()
        {
            Console.WriteLine("YOU’RE BALANCE IN Rs: "+Amount);
            Console.WriteLine();
        }
        private void WithdrawCash()
        {
            
            Console.WriteLine("PLEASE ENTER THE VALUE YOU WANT TO WITHDRAW");
            
            float withrawValue= float.Parse(Console.ReadLine());
            Console.WriteLine();
            if (Amount>=withrawValue)
            {
                Amount = Amount - withrawValue;
                Console.WriteLine("YOU WITHDRAWED : " + withrawValue + "RS TO YOUR ACCOUNT");
                Console.WriteLine();
                Console.WriteLine("YOU’RE BALANCE IN Rs: " + Amount);
                Console.WriteLine();
            }
            else
            {
                Console.WriteLine("YOUR ACCOUNT DO NOT HAVE ENOUGH MONEY TO WITHDRAW");
                Console.WriteLine();
            }
           
        }
        private void DepositCash()
        {
            Console.WriteLine("PLEASE ENTER THE DEPOSIT CASH VALUE");

            float DEPOSITVALUE=float.Parse(Console.ReadLine());
            Amount = Amount + DEPOSITVALUE;
            Console.WriteLine();
            Console.WriteLine("YOU DEPOSITED CASH : " + DEPOSITVALUE + "RS TO YOUR ACCOUNT");
            Console.WriteLine();
            Console.WriteLine("YOU’RE BALANCE IN Rs: " + Amount);
            Console.WriteLine();
        }
       







    }


    class Program
    {
        static void Main(string[] args)
        {
            ATMTransaction a1 = new();
            a1.login();
           
        }
    }
}