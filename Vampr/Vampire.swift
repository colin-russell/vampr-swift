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

import Foundation

class Vampire {
  
  var name: String
  var yearConverted: Int
  var offspring: [Vampire] = []
  var creator: Vampire?
  
  init(name: String, yearConverted: Int) {
    self.name = name
    self.yearConverted = yearConverted
  }
  
  // MARK: Simple tree methods
  
  /// Adds the vampire as an offspring of this vampire
  func add(offspring: Vampire) {
    self.offspring.append(offspring)
    offspring.creator = self
  }
  
  /// The total number of vampires created by that vampire
  var numberOfOffspring: Int {
    return self.offspring.count
  }
  
  /// Returns the number of vampires away from the original vampire this vampire is
  var numberOfVampiresFromOriginal: Int {
    var numberOfVampires = 0
    var currentVampire = self
    
    while true {
      guard let creator = currentVampire.creator else {
        break
      }
      currentVampire = creator
      numberOfVampires += 1
    }
    return numberOfVampires
  }
  
  /// Returns true if this vampire is more senior than the other vampire. (Who is closer to the original vampire)
  func isMoreSenior(than vampire: Vampire) -> Bool {
    if self.numberOfVampiresFromOriginal < vampire.numberOfVampiresFromOriginal {
      return true
    } else {
      return false
    }
  }
  
  // MARK: Tree traversal methods
  
  /// Returns the vampire object with that name, or null if no vampire exists with that name
  func vampire(withName name: String) -> Vampire? {
    
    if self.name == name {
      return self
    }
    
    for vamp in self.offspring {
      if vamp.vampire(withName: name)?.name == name {
        return vamp.vampire(withName: name)
      }
    }
    
    return nil
  }
  
  /// Returns the total number of vampires that exist
  var totalDescendent: Int {
    var numOfDescendents = 0
    for vamp in self.offspring {
      numOfDescendents += vamp.totalDescendent
      numOfDescendents += 1
    }
    return numOfDescendents
  }
  
  /// Returns an array of all the vampires that were converted after 1980
  var allMillennialVampires: [Vampire] {
    var arrayOfMillenials:[Vampire] = []
    
    if self.yearConverted > 1980 {
      arrayOfMillenials.append(self)
    }
    
    for vamp in self.offspring {
      if vamp.allMillennialVampires.count > 0 {
        for v in vamp.allMillennialVampires {
            arrayOfMillenials.append(v)
        }
      }
    }
    
    return arrayOfMillenials
  }
  
  // MARK: Stretch 
  
  /**
    Returns the closest common ancestor of two vampires.
    The closest common anscestor should be the more senior vampire if a direct ancestor is used.
 
    - Example:
      * when comparing Ansel and Sarah, Ansel is the closest common anscestor.
      * when comparing Ansel and Andrew, Ansel is the closest common anscestor.
   */
  func closestCommonAncestor(vampire: Vampire) -> Vampire {
//    if self.creator === vampire.creator {
//      return self.creator!
//    } else if self.isMoreSenior(than: vampire) {
//      return self
//    } else {
//      return vampire
//    }
    if self.creator === vampire.creator {
      return self.creator!
    } else if self.creator != nil && vampire.creator != nil {
      return self.creator!.closestCommonAncestor(vampire: vampire.creator!)
    } else if self.isMoreSenior(than: vampire){
      return self
    } else {
      return vampire
    }
  }

}
