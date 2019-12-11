﻿using _3.WildFarm.Food;
using System;
using System.Collections.Generic;
using System.Text;

namespace _3.WildFarm.Animals.Mammals
{
    public class Mouse : Mammal, IAnimal
    {
        public Mouse(string name, double weight, string livingRegion) : base(name, weight, livingRegion)
        {
        }

        public override string AskForFood()
        {
            return "Squeak";
        }
        public override string ToString()
        {
            return $"{this.GetType().Name} [{this.Name}, {this.Weight}, {this.LivingRegion}, {this.FoodEaten}]";
        }
        public override void Feed(IFood foodType, int quantity)
        {
            if (foodType.GetType().Name != "Vegetable" && foodType.GetType().Name != "Fruit")
            {
                throw new ArgumentException($"{this.GetType().Name} does not eat {foodType.GetType().Name}!");
            }
            this.FoodEaten += quantity;
            this.Weight += quantity * 0.10;
        }
    }
}
