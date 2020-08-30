using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ThesisGamingStore.Models;

namespace ThesisGamingStore.Controllers
{
    public class Item
    {

        private PRODUCT product = new PRODUCT();

        public PRODUCT Product
        {
            get { return product; }
            set { product = value; }
        }
        private int quantity;
        private string discount;
        private int quntityInStock;

        public int QuntityInStock
        {
            get { return quntityInStock; }
            set { quntityInStock = value; }
        }
        public string Discount
        {
            get { return discount; }
            set { discount = value; }
        }
        public int Quantity
        {
            get { return quantity; }
            set { quantity = value; }
        }

        public Item() { }

        public Item(PRODUCT product, int quantity, string discount, int quntityInStock)
        {
            this.product = product;
            this.quantity = quantity;
            this.discount = discount;
            this.quntityInStock = quntityInStock;
        }
    }
}