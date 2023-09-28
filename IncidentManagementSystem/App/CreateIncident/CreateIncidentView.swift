import SwiftUI

struct CreateIncidentRepostView: View {
    @ObservedObject var viewModel: CreateIncidentViewModel

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    Text("Report New Incident")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    CustomTextArea(placeHolder: "Description", text: $viewModel.state.description)
                    DropDownPlaceHolderView(
                        text: viewModel.state.selectedType?.name ?? "Select Type",
                        action: {
                            viewModel.trigger(.present(.types))
                        }
                    )
                    if viewModel.state.showSubCategory {
                        DropDownPlaceHolderView(
                            text: viewModel.state.selectedSubType?.name ?? "Select SubTitle",
                            action: {
                                viewModel.trigger(.present(.subtypes))
                            }
                        )
                    }

                    DropDownPlaceHolderView(
                        text: viewModel.state.address ?? "Select Location",
                        image: "map.fill",
                        action: {
                            viewModel.trigger(.showMap)
                        }
                    )
                    if viewModel.state.showMap {
                        mapAddressView(height: geometry.size.height)
                    }
                    Spacer()
                    PrimaryButtonView(
                        title: "Submit",
                        isDisable: viewModel.state.isSubmitButtonDisable,
                        identifier: "submitReportButton"
                    ) {
                        viewModel.trigger(.submitButtonTapped)
                    }
                }
                .frame(height: geometry.size.height)
                .padding([.horizontal, .bottom])
            }
            .onChange(of: viewModel.state.coordinate) { _ in
                viewModel.trigger(.updateAddress)
            }
        }
        .sheet(item: $viewModel.state.presentType) { state in
            switch state {
            case .types:
                TypesListView(
                    models: viewModel.state.types,
                    action: {
                        viewModel.trigger(.selectType($0))
                    }
                )
            case .subtypes:
                TypesListView(
                    models: viewModel.state.subType,
                    action: {
                        viewModel.trigger(.selectType($0))
                    }
                )
            }
        }

        .ignoresSafeArea(.keyboard, edges: .bottom)
        .background(Color.gray.opacity(0.5))
        .showLoader(isLoading: $viewModel.state.isLoading)
        .onAppear {
            viewModel.trigger(.load)
            viewModel.trigger(.requestLocation)
        }
    }
}

extension CreateIncidentRepostView {
    func mapAddressView(height: CGFloat) -> some View {
        VStack {
            MapView(
                coordinate: $viewModel.state.coordinate,
                span: $viewModel.state.span,
                annotation: $viewModel.state.annotation
            )
            .frame(height: height / 3)
            .overlay {
                Image(systemName: "mappin.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 24)
                    .foregroundColor(.red)
            }
            VStack {
                Spacer()
                HStack {
                    Image(systemName: "location.fill")
                    Text(viewModel.state.address ?? "")
                        .minimumScaleFactor(0.5)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .frame(maxWidth: .infinity)
                )
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreateIncidentRepostView(viewModel: .init())
    }
}
