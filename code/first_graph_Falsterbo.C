// include C++ STL headers 
#include <iostream>
	#include <fstream>
	using namespace std;
	// ROOT library obejcts
#include <TCanvas.h>
#include <TFile.h>
#include <TFrame.h>
#include <TPad.h>
#include <TStyle.h>

void plot_1();
void plot_1(){
//declare of the variables
Double_t temp;
Int_t WDay;
Int_t year;
Int_t CDay;
Double_t WTemp;
Double_t CTemp;
Double_t DTmin;
Double_t DTmax;
Int_t eventNo=0;
//We open the file we are getting the data from
fstream file;
file.open("Plot_1_3_Falsterbo.txt",ios::in);
// now We create the graph
TGraph *Gr1= new TGraph();
Gr1->SetMarkerStyle(kFullCircle);
Gr1->SetLineColor(kBlack);
Gr1->SetTitle("Flasterbo Average temperature");
Gr1->GetXaxis()->SetTitle("Year");
Gr1->GetYaxis()->SetTitle("Temperature(C)");

while(1){
file >> eventNo >> year >> CDay >> CTemp >> WDay >> WTemp >> temp >> DTmin >> DTmax;
/* we used this for debbuging
cout << "Reading event: "<< eventNo <<endl;
cout << "Reading year: "<< year <<endl;
cout << "Reading Warm day: "<< WDay <<endl;
cout << "Reading Warm temp: "<< WTemp <<endl;
cout << "Reading Cold day: "<< CDay <<endl;
cout << "Reading Cold temp "<< CTemp <<endl;
cout << "Reading temperature: "<< temp << endl;*/
Gr1->SetPoint(Gr1->GetN(), year,temp);

if (file.eof()) break;

}
file.close();

TCanvas *c1= new TCanvas();
Gr1->Draw("ALP");

}
