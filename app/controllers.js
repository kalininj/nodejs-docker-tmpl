const products = [
  { id: 1, name: "abc"}, { id: 2, name: "cbd"}, 
]

const controllers = {
  getProductsList: function(req, res) {
    res.status(200).json(products);
  },
  getProduct: function(req, res) {
    res.status(200).json(products[0]);
  }
}

export default controllers