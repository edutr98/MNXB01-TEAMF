// include C++ STL headers 
#include <iostream>
	#include <fstream>
	using namespace std;
	// ROOT library obejcts
#include <TCanvas.h>
#include <TClonesArray.h>
#include <TFile.h>
#include <TFrame.h>
#include <TPad.h>
#include <TStyle.h>

void plot_4();
void plot_4(){
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
fstream file;
file.open("Flasterbo_final.txt",ios::in);

// now We create the graph and the multigraph to plot both at the same time
TMultiGraph *mg = new TMultiGraph();
TGraph *Gr1= new TGraph();
TGraph *Gr2= new TGraph();
Gr1->SetName("Coldest day");
Gr1->SetMarkerStyle(kFullCircle);
Gr1->SetLineColor(kBlue);
Gr2->SetName("Warmest day");
Gr2->SetMarkerStyle(kFullCircle);
Gr2->SetLineColor(kRed);
mg->SetTitle("Diference on temperature between average and Coldest/Warmest day in Falsterbo");
mg->GetXaxis()->SetTitle("Year");
mg->GetYaxis()->SetTitle("Delta T(C)");


while(1){
file >> eventNo >> year >> WDay >> WTemp >> CDay >> CTemp >> temp >> DTmin >> DTmax;
/* we use this for debbuging
cout << "Reading event: "<< eventNo <<endl;
cout << "Reading year: "<< year <<endl;
cout << "Reading Warm day: "<< WDay <<endl;
cout << "Reading Warm temp: "<< WTemp <<endl;
cout << "Reading Cold day: "<< CDay <<endl;
cout << "Reading Cold temp "<< CTemp <<endl;
cout << "Reading temperature: "<< temp << endl;*/
Gr1->SetPoint(Gr1->GetN(), year,DTmin);
Gr2->SetPoint(Gr2->GetN(), year,DTmax);

if (file.eof()) break;

}
file.close();

TCanvas *c1= new TCanvas();
mg->Add(Gr2);
mg->Add(Gr1);
mg->Draw("ALP");
c1->BuildLegend();
}
