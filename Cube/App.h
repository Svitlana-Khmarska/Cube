#pragma once

#include "pch.h"
#include "Common\DeviceResources.h"
#include "CubeMain.h"

/**
@brief Об'єднує інтерфейси програми
*/
namespace Cube
{
	// Main entry point for our app. Connects the app with the Windows shell and handles application lifecycle events.
	ref class App sealed : public Windows::ApplicationModel::Core::IFrameworkView
	{
	public:
		App();

		/** IFrameworkView Methods.
		*/
		virtual void Initialize(Windows::ApplicationModel::Core::CoreApplicationView^ applicationView);
		/** IFrameworkView Methods.
		*/
		virtual void SetWindow(Windows::UI::Core::CoreWindow^ window);
		/** IFrameworkView Methods.
		*/
		virtual void Load(Platform::String^ entryPoint);
		/** IFrameworkView Methods.
		*/
		virtual void Run();
		/** IFrameworkView Methods.
		*/
		virtual void Uninitialize();

	protected:
		/** Application lifecycle event handlers.
		*/
		void OnActivated(Windows::ApplicationModel::Core::CoreApplicationView^ applicationView, Windows::ApplicationModel::Activation::IActivatedEventArgs^ args);
		/** Application lifecycle event handlers.
		*/
		void OnSuspending(Platform::Object^ sender, Windows::ApplicationModel::SuspendingEventArgs^ args);
		/** Application lifecycle event handlers.
		*/
		void OnResuming(Platform::Object^ sender, Platform::Object^ args);

		/** Window event handlers.
		*/
		void OnWindowSizeChanged(Windows::UI::Core::CoreWindow^ sender, Windows::UI::Core::WindowSizeChangedEventArgs^ args);
		/** Window event handlers.
		*/
		void OnVisibilityChanged(Windows::UI::Core::CoreWindow^ sender, Windows::UI::Core::VisibilityChangedEventArgs^ args);
		/** Window event handlers.
		*/
		void OnWindowClosed(Windows::UI::Core::CoreWindow^ sender, Windows::UI::Core::CoreWindowEventArgs^ args);

		/** DisplayInformation event handlers.
		*/
		void OnDpiChanged(Windows::Graphics::Display::DisplayInformation^ sender, Platform::Object^ args);
		/** DisplayInformation event handlers.
		*/
		void OnOrientationChanged(Windows::Graphics::Display::DisplayInformation^ sender, Platform::Object^ args);
		/** DisplayInformation event handlers.
		*/
		void OnDisplayContentsInvalidated(Windows::Graphics::Display::DisplayInformation^ sender, Platform::Object^ args);

	private:
		std::shared_ptr<DX::DeviceResources> m_deviceResources;
		std::unique_ptr<CubeMain> m_main;
		bool m_windowClosed;
		bool m_windowVisible;
	};
}

ref class Direct3DApplicationSource sealed : Windows::ApplicationModel::Core::IFrameworkViewSource
{
public:
	virtual Windows::ApplicationModel::Core::IFrameworkView^ CreateView();
};
