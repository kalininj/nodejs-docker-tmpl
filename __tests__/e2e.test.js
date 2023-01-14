const request = require("supertest")

const app = require("../app/app")

describe('e2e', () => {
  it('should load 1 product', async () => {
    const result = await request(app)
      .get('/products/1')
    expect(result.res.statusCode).toBe(200)
    expect(typeof result.body).toBe('object')
  })    
})
