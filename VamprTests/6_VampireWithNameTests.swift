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

class VampireWithNameTests: XCTestCase {
        
  var rootVampire: Vampire!
  var offspring: (Vampire, Vampire, Vampire, Vampire, Vampire)!
  override func setUp() {
    super.setUp()
    
    rootVampire = Vampire(name: "original", yearConverted: 0)
    offspring = (
      Vampire(name: "andrew", yearConverted: 0),
      Vampire(name: "sarah", yearConverted: 0),
      Vampire(name: "c", yearConverted: 0),
      Vampire(name: "d", yearConverted: 0),
      Vampire(name: "e", yearConverted: 0))
    
    rootVampire.add(offspring: offspring.0)
    offspring.0.add(offspring: offspring.1)
    rootVampire.add(offspring: offspring.2)
    offspring.2.add(offspring: offspring.3)
    offspring.3.add(offspring: offspring.4)
  }
  
  func test_vampireWithName_ShouldReturnTheVampireWithAGivenName_WhenAVampireExistsWithThatName() {
    XCTAssert(rootVampire.vampire(withName: rootVampire.name) === rootVampire)
    XCTAssert(rootVampire.vampire(withName: offspring.0.name) === offspring.0)
    XCTAssert(rootVampire.vampire(withName: offspring.1.name) === offspring.1)
    XCTAssert(rootVampire.vampire(withName: offspring.4.name) === offspring.4)
    XCTAssert(offspring.2.vampire(withName: offspring.4.name) === offspring.4)
  }
  
  func test_vampireWithName_ShouldReturnNil_WhenAVampireDoesNotExistsWithThatName() {
    XCTAssertNil(rootVampire.vampire(withName: ""))
    XCTAssertNil(offspring.1.vampire(withName: offspring.4.name))
  }
}
