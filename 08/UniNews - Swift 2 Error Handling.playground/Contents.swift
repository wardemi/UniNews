//: Playground - noun: a place where people can play


// Any error you wish to throw must conform to the ErrorType protocol. (NSError conforms to this). For example:
enum MyError: ErrorType {
    case ErrorOne
    case ErrorTwo (reason: String)
}
// Note: You may parameterize your errors.


// The function is marked with a throws declaration and may throw any or all of the declared errors:
func functionWithAnError (testString: String) throws {
    if testString == "testString" {
        throw MyError.ErrorOne
    } else if testString == "apples" {
        throw MyError.ErrorTwo (reason: "\(testString) is not allowed.")
    }
}


// Catch the errors using the new do-try-catch statement:

func testErrorHandling (caseString : String) {
    do {
        try functionWithAnError(caseString)
    } catch MyError.ErrorOne {
        print("Error one occurred.")
    } catch MyError.ErrorTwo (let reason) {
        //catch parameterized error
        print("Error two ocurred with reason: \(reason)")
    } catch let unknownError {
        print("\(unknownError) occurred.")
    }
}

// Note: Even though we know that we caught all possible error types, the compiler does not. Therefore to satisfy the compiler, we must add a catch all scenario, similar to a default catch in a switch statement.


// Call test func

testErrorHandling("apples")

//testErrorHandling("testString")
