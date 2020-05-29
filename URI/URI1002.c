#include <iostream>
 
using namespace std;
 
int main() 
{

    double r,n = 3.14159;
    cin >> r;
    cout.setf(ios::fixed, ios::floatfield);
    cout.precision(4);
    cout << "A=" << ((r * r)*n) << endl;
    
    return 0;

}