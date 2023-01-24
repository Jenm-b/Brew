//
//  DrinkGalleryView.swift
//  SwiftUINotes
//
//  Created by Jennifer Munro-Brown on 10/06/2022.
//

import SwiftUI

struct DrinkGalleryView: View {
    // MARK: - Wrapper Properties
    @Environment(\.editMode) private var editMode
    @EnvironmentObject private var route: Router<DrinkDestination>

    @ObservedObject var viewModel: DrinksListGalleryViewModel

    @State private(set) var errorAlertItem: AlertConfiguration?

    // MARK: - Properties
    private let viewTransition: AnyTransition = .asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity)

    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing == true
    }

    private var isAlertPresented: Binding<Bool> {
        Binding<Bool>(
            get: {
                errorAlertItem != nil
            },
            set: { _ in
                errorAlertItem = .none
            }
        )
    }

    private var navigationTitle: String {
        isEditing ? viewModel.editModeNavigationTitle : DrinksListGalleryViewModel.Constants.defaultTitle
    }

    // MARK: - Views
    var body: some View {
        primaryContent
        .clipped() // prevents galleries obscuring bottom tab bar.
        .navigationBarTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(isEditing ? .hidden : .visible, for: .tabBar)
        .toolbar(isEditing ? .visible : .hidden, for: .bottomBar)
        .toolbar {
            titleToolBar
            bottomToolBar
        }
        .accentColor(Color.primaryTheme)
        .alert(isPresented: isAlertPresented) {
            Alert(alertConfiguration: errorAlertItem ?? .item(forType: .generic))
        }
    }

    @ViewBuilder
    var primaryContent: some View {
        ZStack {
            Color.systemGroupedBackground.ignoresSafeArea()
            switch viewModel.viewState {
            case .idle:
                EmptyView()
            case .empty:
                NoDrinksView()
                    .transition(viewTransition)
            case .loaded:
                galleries
                    .transition(.opacity)
            }
        }
    }
}
// MARK: - Gallery Views
private extension DrinkGalleryView {

    var galleries: some View {
        GeometryReader { geometryReader in
            VStack {
                if !isEditing {
                    DrinkInformationGallery(width: geometryReader.size.width,height: geometryReader.size.height)
                }
                switch viewModel.layout {
                case .grid:
                    DrinkGalleryGridView(
                        selectedDrinkIDs: $viewModel.selectedDrinks,
                        drinks: viewModel.drinks,
                        onTap: { drink in
                            pushDetail(drink: drink)
                        }
                    )
                case .list:
                    List(viewModel.drinks, id: \.self, selection: $viewModel.selectedDrinks) { drink in
                            DrinkRowItem(
                                viewModel: DrinkItemViewModel(drink: drink),
                                onTap: {
                                    !isEditing ? pushDetail(drink: drink) : nil
                                }
                            )
                            .contextMenu {
                                !isEditing ? DrinkShareButton(drink: drink): nil
                            }
                            .listStyle(.plain)
                    }
                }
            }
        }
    }
}

// MARK: - Tool Bar Views
private extension DrinkGalleryView {
    @ToolbarContentBuilder
    var titleToolBar: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            addButton
            Menu {
                layoutPicker
                sortPicker
                EditButton()
            } label: {
                Label("Options", systemImage: SFSymbol.menu.title)
                    .labelStyle(.iconOnly)
                    .symbolRenderingMode(.hierarchical)
            }
            .symbolVariant(.fill)
            .disabled(viewModel.viewState != .loaded)
        }
        ToolbarItem(placement: .navigationBarLeading) {
            selectAllButton
                .opacity(isEditing ? 1 : 0)
        }
    }

    @ToolbarContentBuilder
    var bottomToolBar: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            deleteSelectedButton
        }
    }
}

// MARK: - Menu Buttons Views
private extension DrinkGalleryView {
    var addButton: some View {
        Button {
            pushDetail(drink: Drink.defaultDrink())
        } label: {
            Label("Add", systemImage: SFSymbol.plus.title)
                .labelStyle(.iconOnly)
                .symbolRenderingMode(.hierarchical)
        }
        .disabled(isEditing)
    }

    var sortPicker: some View {
        Picker("Sort", selection: $viewModel.sort) {
            ForEach(DrinkSortOrder.allCases, id: \.self) { option in
                Label(option.title, systemImage: option.icon.title)
                    .labelStyle(.iconOnly)
            }
        }
        .pickerStyle(.inline)
        .disabled(isEditing)
    }

    var layoutPicker: some View {
        Picker("Layout", selection: $viewModel.layout) {
            ForEach(BrowserLayout.allCases, id: \.self) { option in
                Label(option.title, systemImage: option.icon.title)
                    .labelStyle(.iconOnly)
            }
        }
        .pickerStyle(.inline)
    }

    var deleteSelectedButton: some View {
        Button(role: .destructive) {
            deleteSelectedDrinks()
        } label: {
            Label("Delete Selected", systemImage: SFSymbol.trash.title)
                .labelStyle(.titleAndIcon)
                .symbolRenderingMode(.hierarchical)
        }
        .disabled(viewModel.noDrinksSelected)
    }

    var selectAllButton: some View {
        Button {
            selectAllDrinks()
        } label: {
            Text("\(viewModel.allDrinksSelected ? "Des" : "S")elect All")
        }
    }
}


// MARK: - Helper Methods
private extension DrinkGalleryView {
    func deleteSelectedDrinks() {
        Task {
            do {
                try await viewModel.delete()
                await MainActor.run {
                    editMode?.animation().wrappedValue = .inactive
                    print("\(Thread.isMainThread) This is on the main actor.")
                }
            } catch let error {
                await MainActor.run {
                    errorAlertItem = AlertConfiguration.item(forType: .serviceError(error))
                }
            }
        }
    }

    @MainActor
    func selectAllDrinks() {
        viewModel.handleSelectAll()
    }

    func pushDetail(drink: Drink) {
        route.push(.drinkDetail(drink))
    }
}
//
//struct DrinkGalleryView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            DrinkGalleryView(viewModel: <#DrinksListGalleryViewModel#>)
//        }
//    }
//}
