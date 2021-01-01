# SWENSON-HE-Task
This is the implementation of currency converter task using MVVVM-C architecture
I tried to build a clean architecture as much as possible by decoupling code into layers, each layer has one reposnibility
1)View Layer: Render View.
2)View Model: Presentation Logic.
3)Service Layer: Bussiness Login.
4)Data Source Layer: Data Logic.

I also implemented a demo test case as a sample for unit testing.

Notes:
1)Fixer API don't support change base currency on the free plan, so i implemented an extra logic on client side to handle changine base currency.
2)I didn't provide unit testing for all of code, the provided unit testing is just a sample only.
3) I implemented stubbers for mocking API responses to make unit testing works offline.



