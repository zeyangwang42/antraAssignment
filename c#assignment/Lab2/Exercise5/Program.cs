
namespace Exercise5
{
    class Box
    {
        double length, breadth, height;
        public double getVolume()
        {
            return length * breadth * height;
        }
        public void setLength(double len)
        {
            length = len;
        }
        public void setBreadth(double bre)
        {
            breadth = bre;
        }
        public void setHeight(double hei)
        {
            height = hei;
        }
        public static Box operator +(Box b, Box c)
        {
            Box box = new Box();
            box.length = b.length + c.length;
            box.breadth = b.breadth + c.breadth;
            box.height = b.height + c.height;
            return box;
        }
        public static Box operator -(Box b, Box c)
        {
            Box box = new Box();
            box.length = b.length - c.length;
            box.breadth = b.breadth - c.breadth;
            box.height = b.height - c.height;
            return box;
        }
        
        static void Main()
        {
            Box b1= new Box();
            Box b2 = new Box();
            Box b3 = new Box();

            b1.setBreadth(2);
            b1.setLength(4);
            b1.setHeight(6);


            b2.setBreadth(1);
            b2.setLength(3);
            b2.setHeight(4);

            double volume;
            volume = b1.getVolume();
            Console.WriteLine("Volume if Box1： {0}", volume);
            volume = b2.getVolume();
            Console.WriteLine("Volume if Box1： {0}", volume);
            b3 = b1 + b2;
            volume = b3.getVolume();
            Console.WriteLine("Volume if Box1： {0}", volume);
        }
    }
}