#include <iostream>
 
using namespace std;
 
int main() 
{

    double a, b;
    cin >> a;
    cin >> b;
    cout.setf(ios::fixed, ios::floatfield);
    cout.precision(5);
    cout << "MEDIA = " << ((a*3.5 + b*7.5)/11) << endl;
    
    return 0;

}