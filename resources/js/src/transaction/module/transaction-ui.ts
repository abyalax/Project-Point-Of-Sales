import { CategoryScale, Chart, BarController, LinearScale, LineController, LineElement, PointElement, BarElement, Filler, Tooltip, PieController, ArcElement, Legend } from "chart.js";

Chart.register([
    CategoryScale,
    BarController,
    BarElement,
    LineController,
    LineElement,
    PieController,
    ArcElement,
    LinearScale,
    PointElement,
    Filler,
    Tooltip,
    Legend,
]);

interface ChartElements {
    revenue?: Chart,
    category?: Chart
}

export default class TransactionUI {
    private charts: ChartElements;

    constructor() {
        this.charts = {
            revenue: undefined,
        }
        this.bindEvents()
    }

    private bindEvents() {
        const revenue = document.getElementById('revenue-chart') as HTMLCanvasElement
        const category = document.getElementById('category-chart') as HTMLCanvasElement
        this.createRevenueChart(revenue)
        this.createSalesByCategoryChart(category)
    }

    private createRevenueChart = (canvas: HTMLCanvasElement) => {
        this.destroyChartFromCanvas(canvas)
        this.charts.revenue = new Chart(canvas, {
            type: "line",
            data: {
                labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                datasets: [
                    {
                        label: "Sales",
                        fill: true,
                        tension: 0.4,
                        borderCapStyle: "round",
                        pointRadius: 0.2,
                        backgroundColor: "transparent",
                        borderColor: "#30b4e1",
                        data: [2115, 1562, 1584, 1892, 1487, 2223, 2966, 2448, 2905, 3838, 2917, 3327]
                    },
                    {
                        label: "Revenue",
                        fill: true,
                        tension: 0.4,
                        borderCapStyle: "round",
                        pointRadius: 0.2,
                        backgroundColor: "transparent",
                        borderColor: "#3b7ddd",
                        data: [2215, 1462, 1384, 1792, 1287, 2123, 3066, 1448, 2705, 3638, 2717, 3427]
                    },
                    {
                        label: "Profit",
                        fill: true,
                        tension: 0.4,
                        borderCapStyle: "round",
                        pointRadius: 0.2,
                        backgroundColor: "transparent",
                        borderColor: "#23bf93",
                        borderDash: [4, 4],
                        data: [958, 724, 629, 883, 915, 1214, 1476, 1212, 1554, 2128, 1466, 1827]
                    }
                ]
            },
            options: {
                aspectRatio: 4 / 2,
                interaction: {
                    intersect: false,
                    mode: 'index',
                },
                plugins: {
                    tooltip: {
                        enabled: true,
                        mode: 'index'
                    },
                    legend: {
                        display: true,
                        align: 'center',
                    }
                },
            }
        })
    }

    // // Darker version of #727272

    private createSalesByCategoryChart = (canvas: HTMLCanvasElement) => {
        this.destroyChartFromCanvas(canvas);
        this.charts.category = new Chart(canvas, {
            type: "pie",
            data: {
                labels: ['Makanan', 'Minuman', 'Perlengkapan Rumah', 'Elektronik', 'Perawatan Pribadi', 'Hair Styling'],
                datasets: [
                    {
                        label: "Penjualan per Kategori",
                        data: [365, 243, 323, 123, 303, 98],
                        borderWidth: 1,
                        backgroundColor: [
                            "#30b4e1",
                            "#3b7ddd",
                            "#23bf93",
                            "#ff6b6b",
                            "#ff9f43",
                            "#e9c46a"
                        ],
                        hoverBackgroundColor: [
                            "#1e8fb7",  // Darker version of #30b4e1
                            "#2662b0",  // Darker version of #3b7ddd
                            "#178068",  // Darker version of #23bf93
                            "#cc5252",  // Darker version of #ff6b6b
                            "#cc7c26",  // Darker version of #ff9f43
                            "#b89a4f"   // Darker version of #e9c46a
                        ]
                    }
                ]
            },
            options: {
                aspectRatio: 1,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        enabled: true,
                        mode: 'nearest'
                    }
                },
                interaction: {
                    intersect: false,
                    mode: 'index',
                }
            }
        });
    }

    private destroyChartFromCanvas(canvas: HTMLCanvasElement) {
        const existingChart = Chart.getChart(canvas);
        if (existingChart) {
            existingChart.destroy();
        }
    }
}