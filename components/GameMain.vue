<template>
  <div class="GameMain">
    <client-only>
      <GameStats
        :step="stepNumber"
        :game-started-at="startedAt"
        :timer-in-progress="stepNumber > 0 && gameInProgress"
        :game-is-won="gameIsWon"
      />

      <transition-group
        name="GameTile"
        tag="div"
        class="GameMain__container"
      >
        <GameTile
          v-for="num in tiles"
          :key="num"
          :number="num"
          :is-empty="num === 0"
          @click.native="moveTile(num)"
        />
      </transition-group>

      <div class="GameMain__restartContainer">
        <button
          class="GameMain__restartButton GameButton"
          @click="startNewGame"
        >
          Начать новую игру
        </button>
      </div>
    </client-only>
  </div>
</template>

<script>
import GameStats from '~/components/GameStats.vue'
import GameTile from '~/components/GameTile.vue'

function getInitialTiles () {
  const tiles = Array.from({length: 15}, (v, i) => i + 1)
  tiles.push(0)

  return tiles
}

export default {
  name: 'GameMain',

  components: {
    GameStats,
    GameTile,
  },

  data: () => ({
    tiles: getInitialTiles(),
    stepNumber: 0,
    startedAt: Date.now(),
    gameInProgress: false,
    gameIsWon: false,
  }),

  computed: {
    initialTilesOrder () {
      return getInitialTiles()
    },
    initialTilesOrderString () {
      return this.initialTilesOrder.join()
    },
    emptyCellPosition () {
      return this.tiles.indexOf(0)
    },
  },

  watch: {
    tiles (val) {
      if (val.join() === this.initialTilesOrderString) {
        this.completeTheGame()
      }
    },
    stepNumber (val, oldVal) {
      if (oldVal === 0) {
        this.gameInProgress = true
      }
    },
    gameInProgress (val) {
      if (!!val) {
        this.startedAt = Date.now()
      }
    },
  },

  created () {
    this.shuffleTiles()
  },

  methods: {
    shuffleTiles () {
      this.tiles.sort(() => Math.random() - 0.5)
    },
    startNewGame () {
      this.shuffleTiles()
      this.stepNumber = 0
      this.startedAt = Date.now()
      this.gameInProgress = false
      this.gameIsWon = false
    },
    completeTheGame () {
      this.gameInProgress = false
      this.gameIsWon = true
      this.$emit('game-was-won')
    },
    getTilePosition (tile) {
      return this.tiles.indexOf(tile)
    },
    isMoveable (num) {
      const tilePosition = this.getTilePosition(num)
      const emptyTilePosition = this.emptyCellPosition
      const colsAmount = 4

      // смотрим, чтобы перемещаемый тайл и пустой находились по соседству (1 - слева-справа, colsAmount - друг над другом)
      return [1, colsAmount].includes(Math.abs(tilePosition - emptyTilePosition))
    },
    moveTile (num) {
      if (!this.isMoveable(num)) {
        return
      }
      const tilePos = this.getTilePosition(num)
      this.$set(this.tiles, this.emptyCellPosition, num)
      this.$set(this.tiles, tilePos, 0)
      this.stepNumber++
    },
  },
}
</script>

<style lang="scss">
  @import '~assets/styles/variables';

  .GameMain {
    min-width: 300px;
    width: 100%;
    padding: 15px;

    background-color: $gameFieldBg;

    &__container {
      display: grid;

      grid-template-areas: 'a a a a';
      grid-template-columns: repeat(4, 1fr);
      grid-template-rows: repeat(4, 1fr);
      grid-gap: 0.4rem;
    }

    &__restartContainer {
      margin-top: 1rem;
    }

    &__restartButton {
      display: block;
      width: 100%;
    }
  }

  /* Анимации движения тайлов */
  .GameTile-move {
    transition: all .1s ease-in;
  }
</style>
