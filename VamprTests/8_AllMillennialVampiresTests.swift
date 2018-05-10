// Copyright (c) 2017 Lighthouse Labs. All rights reserved.
// 
// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical or
// instructional purposes related to programming, coding, application development,
// or information technology.  Permission for such use, copying, modification,
// merger, publication, distribution, sublicensing, creation of derivative works,
// or sale is expressly withheld.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import XCTest
@testable import Vampr

class AllMillennialVampiresTests: XCTestCase {
        
  var rootVampire: Vampire!
  var offspring: (Vampire, Vampire, Vampire, Vampire, Vampire, Vampire, Vampire, Vampire)!
  override func setUp() {
    super.setUp()
    
    rootVampire = Vampire(name: "original", yearConverted: 0)
    offspring = (
      Vampire(name: "a", yearConverted: 1000),
      Vampire(name: "b", yearConverted: 900),
      Vampire(name: "c", yearConverted: 1400),
      Vampire(name: "d", yearConverted: 1890),
      Vampire(name: "e", yearConverted: 1990),
      Vampire(name: "f", yearConverted: 2000),
      Vampire(name: "g", yearConverted: 2010),
      Vampire(name: "h", yearConverted: 2017))
    
    rootVampire.add(offspring: offspring.0)
    rootVampire.add(offspring: offspring.1)
    rootVampire.add(offspring: offspring.2)
    offspring.2.add(offspring: offspring.3)
    offspring.2.add(offspring: offspring.4)
    offspring.4.add(offspring: offspring.5)
    offspring.5.add(offspring: offspring.6)
    offspring.1.add(offspring: offspring.7)
  }
  
  func test_allMillennialVampires_ShouldReturnAnArrayOfAlllVampiresConvertedAfter1980() {
    let millennials = rootVampire.allMillennialVampires
    
    func makeVampireIsEqualTo(_ vampire: Vampire) -> ((Vampire) -> Bool) {
      func vampireIsEqualTo(_ compareVampire: Vampire) -> Bool {
        return vampire === compareVampire
      }
      return vampireIsEqualTo
    }
    
    XCTAssertEqual(millennials.count, 4)
    XCTAssert(millennials.contains(where: makeVampireIsEqualTo(offspring.4)))
    XCTAssert(millennials.contains(where: makeVampireIsEqualTo(offspring.5)))
    XCTAssert(millennials.contains(where: makeVampireIsEqualTo(offspring.6)))
    XCTAssert(millennials.contains(where: makeVampireIsEqualTo(offspring.7)))
  }
    
}
